# frozen_string_literal: true

Sequel.migration do
  change do
    # these are private messages that a visitor or an author may send
    # from homepage to webadmin
    create_table(:messages) do
      primary_key :id, type: :Bignum
      TrueClass :identified_author, null: false, default: true
      String :name, size: 250, null: false
      String :first_name, size: 250, null: false
      String :text, text: true
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_join_table(author_id: :authors, message_id: :messages)
  end
end
