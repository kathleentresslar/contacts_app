class Api::ContactsController < ApplicationController
  def display_contact
    @contact = Contact.first
    render "first_contact.json.jb"
  end

  def index
    @contacts = Contact.all
    render "index.json.jb"
  end

  def show
    @contact = Contact.find_by(id: params["id"])
    render "show.json.jb"
  end

  def create
    @contact = Contact.new(first_name: params["first_name"], last_name: params["last_name"], phone_number: params["phone_number"], email: params["email"], bio: params["bio"], middle_name: params["middle_name"])

    if @contact.save
      render "show.json.jb"
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params["id"])
    @contact.first_name = params["first_name"] || @contact.first_name
    @contact.last_name = params["last_name"] || @contact.last_name
    @contact.email = params["email"] || @contact.email
    @contact.phone_number = params["phone_number"] || @contact.phone_number
    @contact.middle_name = params["middle_name"] || @contact.middle_name
    @contact.bio = params["bio"] || @contact.bio

    if @contact.save
      render "show.json.jb"
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find_by(id: params["id"])
    @contact.destroy
    render json: { message: "destroyed!" }
  end
end
