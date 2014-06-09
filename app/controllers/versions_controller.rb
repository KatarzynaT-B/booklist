class VersionsController < ApplicationController
  def revert
    params[:elements].each do |element|
      @version = PaperTrail::Version.find(element)
      if @version.reify
        @version.reify.save!
      else
        @version.item.destroy
      end
    end
    redirect_to :back, notice: "Cofnięto akcję"
  end
end
