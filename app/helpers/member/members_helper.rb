module Member::MembersHelper
  def gender_option
    genders = []
    Member.genders_i18n.each do |key, value|
      genders << [key,value]
    end
  end
end
