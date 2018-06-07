module SharedExampleHelpers

  def show?(actions); !([actions].flatten & [:crud, :show]).empty?; end
  def index?(actions); !([actions].flatten & [:crud, :index]).empty?; end
  def update?(actions); !([actions].flatten & [:crud, :update]).empty?; end
  def create?(actions); !([actions].flatten & [:crud, :create]).empty?; end
  def destroy?(actions); !([actions].flatten & [:crud, :destroy]).empty?; end

end
