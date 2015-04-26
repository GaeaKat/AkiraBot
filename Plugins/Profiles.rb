class Profiles
  include Cinch::Plugin

  match /profile set$/i, method: :setProfile 
  match /age (\d+)$/i, method: :setAge
  match /gender (.*$)/i, method: :setGender
  match /location (.*$)/i, method: :setLocation
  match /position (.*$)/i, method: :setPosition
  match /limits (.*$)/i, method: :setLimits
  match /kinks (.*$)/i, method: :setKinks
  match /desc (.*$)/i, method: :setDesc
  match /view (.*$)/, method: :viewProfile
  def setProfile(m)
    m.reply "Please tell me your age with !age"
  end
  
  
  def viewProfile(m,name)
    user=User.getUserFromUser(User(name))
    prof=user.profile
    
    if prof.nil? 
      m.reply "Profile not found"
      return
    end
    m.reply "Name: #{user.name}"
    m.reply "Age: #{prof.age}"
    m.reply "Gender: #{prof.gender}"
    m.reply "Location: #{prof.location}"
    m.reply "Position: #{prof.position}"
    m.reply "Kinks: #{prof.kinks}"
    m.reply "Limits: #{prof.limits}"
    m.reply "Description: #{prof.description}"
  end
  
  def setAge(m,age)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.age=age
    prof.save
    m.reply "Thank you. Please tell me your gender with !gender"
  end
  
  def setGender(m,gender)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.gender=gender
    prof.save
    m.reply "Okay. Please tell me your location. Where do you live? Tell me with !location"
  end
  
  def setLocation(m,location)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.location=location
    prof.save
    m.reply "Thank you. Please tell me your position - are you a dominant, a submissive, a switch, or something that doesn’t fall into any of those categories? Tell me with !position"
  end
  def setPosition(m,position)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.position=position
    prof.save
    m.reply "Please tell me your limits in general. Don’t worry about trigger limits, those will come later. tell me with !limits"
  end
  
  def setLimits(m,limits)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.limits=limits
    prof.save
    m.reply "Okay, that’s great. Now, please tell me what you do like. What are your kinks? Tell me with !kinks"
  end
  def setKinks(m,kinks)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.kinks=kinks
    prof.save
    m.reply "Give us a description of yourself, please. You can use as much or as little detail as you feel comfortable with. Tell me with !desc"
  end
  def setDesc(m,desc)
    prof=User.getUserFromUser(m.user).profile
    if prof.nil?
      User.getUserFromUser(m.user).create_profile
      prof=User.getUserFromUser(m.user).profile
    end
    prof.description=desc
    prof.save
    m.reply "Thank you, your profile has been created."
    Channel("#triggerplay").msg("#{m.user} has created a new profile. Please type !view #{m.user} to view it, if you would like.")
  end
  
end