Sequel.migration do
    change do
        create_table(:categories) do
            primary_key :id, :type => :Bignum
            String :intitule, size: 250, null: false
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
    
        create_table(:articles) do
            primary_key :id, :type => :Bignum
            # each article may have several authors so join table, no foreign key
            String :title, size: 250, null: false
            String :slug, size: 250, null: false
            String :text, text: true
            FalseClass :published, null: false, default: false
            # by default, authors refuse comments on articles
            FalseClass :allows_comments, null: false, default: false
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
    
        create_table(:images) do
            primary_key :id, :type => :Bignum
            String :replacement_text, size: 250
            String :url, text: true
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
    
        create_table(:comments) do
            primary_key :id, :type => :Bignum
            # a person may leave only one comment per article
            foreign_key :author_id, :authors, :null=>false, :index => true, :type=>:Bignum
            String :text, text: true
            DateTime :created_at, :null=>false, :default=>Sequel::CURRENT_TIMESTAMP
        end
    
        create_join_table(categorie_id: :categories, article_id: :articles)
        create_join_table(author_id: :authors, article_id: :articles)
        create_join_table(image_id: :images, article_id: :articles)
    end
end