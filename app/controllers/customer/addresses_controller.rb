class Customer::AddressesController < ApplicationController

  def index
    @address=Address.new
    @addresses=Address.all
  end
end