# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Enums
  enum :role, { user: 0, admin: 1 }

  # Validations
  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "formato de email inválido" }
  validates :password, presence: true, length: { minimum: 8, maximum: 20 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  before_save { self.email = email.downcase }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_role, ->(role) { where(role: role) }
  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  scope :search_by_email, ->(query) { where("email ILIKE ?", "%#{query}%") }

  # Ransack: permitir busca em associações
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email role]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
