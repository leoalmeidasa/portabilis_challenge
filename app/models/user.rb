# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Enums
  enum :role, { employee: 0, admin: 1 }

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

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

  def employee?
    role == 'employee'
  end
end
