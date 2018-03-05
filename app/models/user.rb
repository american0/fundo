class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pledges
  has_many :foundation, -> { distinct }, through: :pledges
  has_many :wallets, as: :walletable
  has_many :projects

  default_scope -> { order("created_at ASC") }

  def token_balance(foundation)
    binding.pry
    received_token_transactions.sum(:amount) - sent_token_transactions.sum(:amount)
  end
end
