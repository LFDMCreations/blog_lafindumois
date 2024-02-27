# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:authors) do
      primary_key :id, type: :Bignum
      String :name, size: 250, null: false
      String :first_name, size: 250, null: false
      # authors get a subdomain identified by their slug.
      String :slug, size: 250, null: false
      citext :email, null: false
      constraint :valid_email, email: /^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$/
      index :email, unique: true
      FalseClass :accepted_contract, null: false, default: false
      FalseClass :accepts_newsletter, null: false, default: false
      FalseClass :accepts_infopopups, null: false, default: false
      # when accepted_tiers_account is true,
      # the author granted another author with visibility on his account
      FalseClass :accepted_tiers_account, null: false, default: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_table(:author_activity) do
      # how often did a author change name, password, newsletter subscription or email?
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, index: true, type: :Bignum, unique: true
      Integer :changed_name, default: nil
      Integer :changed_password, default: nil
      Integer :changed_newsletter, default: nil
      Integer :changed_email, default: nil
    end

    create_table(:author_password_hashes) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, index: true, type: :Bignum, unique: true
      String :password_digest, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_table(:author_newsletters) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, index: true, type: :Bignum, unique: true
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_table(:author_temp_codes) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, type: :Bignum, unique: true
      String :temp_code, default: nil
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    # track at what state of account creation the author is.
    # 0 = account creation completed
    create_table(:author_validation_status) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, type: :Bignum, unique: true
      String :password_digest, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_table(:author_connexions) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, index: true, type: :Bignum
      String :localisation, default: nil
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    # jwt refresh token
    create_table(:author_jwt_refresh_keys) do
      primary_key :id, type: :Bignum
      foreign_key :author_id, :authors, null: false, type: :Bignum, unique: true
      String :token, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :deadline, null: false
    end

    run 'ALTER TABLE authors ADD UNIQUE (slug)'
    run 'ALTER TABLE authors ADD UNIQUE (email)'
  end
end
