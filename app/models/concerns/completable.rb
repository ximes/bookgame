module Completable
  extend ActiveSupport::Concern

  def complete!
    if completable?
      self.completed = true
      save!
    end
  end

  def uncomplete!
    self.completed = false
    save!
  end

  def uncompleted?
    !completed?
  end  

end