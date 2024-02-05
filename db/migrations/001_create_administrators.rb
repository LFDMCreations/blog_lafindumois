Sequel.migration do
    change do
        create_table(:administrators) do
            primary_key :id, :type=>:Bignum
            String :name, size: 250, null: false
            String :first_name, size: 250, null: false
            FalseClass :administrator, null: false, default: true
            citext :email, :null=>false
            constraint :valid_email, :email=>/^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$/
            index :email, :unique=>true
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
      
        create_table(:administrator_password_hashes) do
            primary_key :id, :type=>:Bignum
            foreign_key :administrator_id, :administrators, :null=>false, :index => true, :type=>:Bignum, :unique=>true
            String :password_digest, :null=>false 
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
    
        create_table(:administrator_jwt_refresh_keys) do
            primary_key :id, :type=>:Bignum
            foreign_key :administrator_id, :administrators, :null=>false, :type=>:Bignum, :unique=>true
            String :token, :null=>false
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
            DateTime :deadline, :null=>false
        end
    
        run "ALTER TABLE administrators ADD UNIQUE (email)"
    end
end
