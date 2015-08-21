class MyDevise::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if resource.save
      resource.name = "test"
      resource.save
    end
  end
end