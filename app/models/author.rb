class Author < Sequel::Model
    # def validate
    #     super
    #     errors.add(:name, "can't be empty") if name.empty?
    #     errors.add(:first_namename, "can't be empty") if first_name.empty?
    # end

    def essaie(quoi)
        if quoi === "oui"
            "ça va"            
        else
            "aie"
        end
    end

end