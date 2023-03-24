class Payment < ApplicationRecord
         belongs_to :documento, autosave: true
         has_many_attached :uploads 
end
