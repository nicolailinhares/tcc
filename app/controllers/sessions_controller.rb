# encoding: utf-8

class SessionsController < Devise::SessionsController
   def destroy
     super
   end
end