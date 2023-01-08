desc "All the Surveyors should be users, after this the surveyors table should be droped"
task convert_surveyors_to_users: :environment do
  # we have to shift the surveyors to users table, so make a user for every surveyor, if already present
  # then update the details
  surveyors = Surveyor.all
  if surveyors.blank?
    return
  end
  surveyors.find_each do |surveyor|
    if surveyor.login.nil?
      # this is chad's surveyor record, currently this record's login is nil on surveyor table
      # chad db id is 5
      user = User.find_by_id(5)
      if user.present? # a guard even here? :)
        user.initials = surveyor.initials
        user.two_digit_id = surveyor.two_digit_id
        user.company_id = surveyor.company_id
        if user.save
          puts "SUCCESS::chad user updated"
        else
          puts "FAILED:: chad user not updated"
        end
      end
    else
      # apart from chad, create a new user record for every surveyor
      user = User.new(email: surveyor.login, two_digit_id: surveyor.two_digit_id, initials: surveyor.initials, password: surveyor.password, company_id: surveyor.company_id)
      user.name = surveyor.name
      if user.save
        puts "SUCCESS:: user updated"
      else
        puts "FAILED:: user not updated"
      end
    end
  end

end