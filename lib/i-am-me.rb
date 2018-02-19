module IAmMe

  extend ActiveSupport::Concern

  included do
    before_action :set_me
    helper_method :me, :my
  end

  class_methods do
    def me_is_a(type_of_me)
      @type_of_me = type_of_me
    end
  end

  def set_me
    # before_actionフックによりset_meメソッドがコールされるコントローラは`me_is_a`メソッドがコールされたコントローラと同じとは限らないため、
    # ancestorsを遡ってtype_of_meを探す。
    type_of_me = nil
    self.class.ancestors.each do |ancestor|
      type_of_me = ancestor.instance_variable_get(:@type_of_me)
      break if type_of_me
      break if ancestor == ApplicationController
    end
    return unless respond_to?("current_#{type_of_me}")
    RequestStore[:me] = send("current_#{type_of_me}")
  end

  def me
    RequestStore[:me]
  end

  alias_method :my, :me

end
