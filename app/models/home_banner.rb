class HomeBanner < ActiveRecord::Base
	attr_accessible *attribute_names

	scope :published, -> { where(published: 't') }
	scope :sort_by_sorting_position, -> { order('sorting_position asc') }


  def self.initialize_globalize
        translates :description
        accepts_nested_attributes_for :translations
        attr_accessible :translations, :translations_attributes

        Translation.class_eval do
          self.table_name = :home_banner_translations
          attr_accessible *attribute_names
          belongs_to :home_banner, class_name: "HomeBanner"

          
        end
      end


  if self.table_exists?
    initialize_globalize
  end

	[:image].each do |attachment_name|
    has_attached_file attachment_name, styles: { full_width: "1980x500#"  }
    do_not_validate_attachment_file_type attachment_name
    attr_accessible attachment_name
  end
end