class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
    # figure out the sort direction
    sort_dir = params[:sort_dir] ? params[:sort_dir].capitalize : 'ASC'

    # get the page size
    page_size = params[:page_size] ? params[:page_size] : DEFAULT_PAGE_SIZE
    
    # search for the groups, with pagination
    if params[:search].blank?
      @groups = Group.paginate :page => params[:page], :per_page => page_size, :order => "name #{sort_dir}"
    else
      @groups = Group.search params[:search], :page => params[:page], :per_page => page_size, :order => "name #{sort_dir}"
    end
    
    # unless @groups.nil?
    #   puts "found #{@groups.size.to_s} groups"
    #   puts "first name: #{@groups[0].name}"
    # end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])
    
    @events = @group.events
    
    @google_maps_url = nil
    
    unless (@events.nil? || (@events.length == 0))
      @google_maps_url = generate_google_maps_url(@events)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def generate_google_maps_url(events)
    return nil unless (!events.nil? && events.length > 0)
      
    map_url = "http://maps.google.com/staticmap?size=512x512\&markers="
    
    events.each do |event|
      map_url += event.location.latitude.to_s + "," + event.location.longitude.to_s
      
      unless event == events.last
        map_url += "%7C"
      end
    end
    
    map_url += "\&key=#{GOOGLE_MAPS_KEY}&sensor=false"
    
    map_url
  end
end
