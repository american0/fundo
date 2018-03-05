class Foundation < ApplicationRecord
  geocoded_by :postal_code_and_country
  after_validation :geocode
  before_create :set_locality

  has_many :projects
  has_many :pledges
  has_many :payments
  has_many :eth_transactions
  has_many :token_transactions
  has_many :users, -> { distinct }, through: :pledges
  has_many :wallets, as: :walletable

  validates :country_alpha2, presence: true
  validates :local_currency, presence: true
  validates :postal_code, presence: true
  validates :min_starting_funds, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :min_participants, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :activation_deadline, presence: true
  validate :activation_deadline_must_be_in_future

  default_scope -> { order("created_at ASC") }

  def postal_code_and_country
    [postal_code, country_alpha2].join(' ')
  end

  def active?
    activated_on.present?
  end

  def activate
    if !active? && thresholds_met?
      self.update(activated_on: Time.now)
      Wallet.create(walletable: self, content_type: 'eth', foundation_id: id)
      Wallet.create(walletable: self, content_type: 'token', foundation_id: id)
      PaymentService.new(self).process_monthly
    end
  end

  def balance
    eth_transactions.sum(:amount).round(4)
  end

  def deploy
    EthereumService.new(self).deploy_contract
  end

  def name
    "Community Foundation of #{locality_name} (#{postal_code})"
  end

  def pledge_total
    pledges.sum(:amount).to_f
  end

  def status
    if activated_on.nil? && !thresholds_met? && activation_deadline <= Date.today
      "Expired"
    elsif activated_on.present?
      "Active"
    else
      "Pending"
    end
  end

  private

  def activation_deadline_must_be_in_future
    if activation_deadline.present? && activation_deadline < Date.today
      errors.add(:activation_date, 'must be in the future.')
    end
  end

  def thresholds_met?
    funding_threshold_met? && participant_threshold_met?
  end

  def funding_threshold_met?
    pledge_total >= min_starting_funds
  end

  def participant_threshold_met?
    users.size >= min_participants
  end

  def set_locality
    self.locality_name = GeocoderService.new(self.latitude, self.longitude).fetch_locality
  end
end

