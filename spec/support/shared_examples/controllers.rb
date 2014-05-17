shared_examples_for "GET #index" do
  before do
    sign_in
    get :index
  end

  it "responds successfully with an HTTP 200 status code" do
    expect(response).to be_ok
  end

  it "renders the index template" do
    expect(response).to render_template("index")
  end

  it "loads all of the resources into @resources" do
    expect(assigns(subject)).to eq([resource])
  end
end

shared_examples_for "GET #show" do
  before do
    sign_in
    get :show, id: resource
  end

  it "assigns the requested resource to @resource" do
    expect(assigns(subject)).to eq(resource)
  end

  it "renders the #show view" do
    expect(response).to render_template("show")
  end
end

shared_examples_for "GET #new" do
  before do
    sign_in
  end

  it "renders the #new view" do
    get :new
    expect(response).to render_template("new")
  end
end

shared_examples_for "GET #edit" do
  before do
    sign_in
    get :edit, id: resource
  end

  it "assigns the requested resource to @resource" do
    expect(assigns(subject)).to eq(resource)
  end

  it "renders the #edit view" do
    expect(response).to render_template("edit")
  end
end

shared_examples_for "POST create" do
  before do
    sign_in
  end

  context "with valid attributes" do
    it "creates a new resource" do
      expect{ post :create, subject => other_resource }.to change(resource.class, :count).by(1)
    end

    it "redirects to the new resource" do
      post :create, subject => other_resource
      expect(response).to redirect_to redirect_to(action: :index)
    end
  end

  context "with invalid attributes" do
    it "does not save the new resource" do
      expect{ post :create, subject => invalid_resource }.to_not change(resource.class, :count)
    end

    it "re-renders the new method" do
      post :create, subject => invalid_resource
      expect(response).to render_template :new
    end
  end
end

shared_examples_for "PUT update" do
  before do
    sign_in
    @resource = resource
  end

  context "valid attributes" do
    it "located the requested @resource" do
      put :update, id: @resource, subject => other_resource
      expect(assigns(subject)).to eq(@resource)
    end

    it "changes @resource's attributes" do
      put :update, id: @resource, subject => other_resource
      @resource.reload
      other_resource.keys.each { |k| expect(@resource.send(k)).to eq(other_resource[k]) }
    end

    it "redirects to the updated resource" do
      put :update, id: @resource, subject => other_resource
      expect(response).to redirect_to @resource
    end
  end

  context "invalid attributes" do
    it "locates the requested @resource" do
      put :update, id: @resource, subject => invalid_resource
      expect(assigns(subject)).to eq(@resource)
    end

    it "does not change @resource's attributes" do
      put :update, id: @resource, subject => invalid_resource
      @resource.reload
      other_resource.keys.each { |k| expect(@resource.send(k)).not_to eq(invalid_resource[k]) }
    end

    it "re-renders the edit method" do
      put :update, id: @resource, subject => invalid_resource
      expect(response).to render_template :edit
    end
  end
end

shared_examples_for "DELETE destroy" do
  before do
    sign_in
    @resource = resource
  end

  it "deletes the resource" do
    expect{ delete :destroy, id: @resource }.to change(resource.class, :count).by(-1)
  end

  it "redirects to resources#index" do
    delete :destroy, id: @resource
    expect(response).to redirect_to(action: :index)
  end
end
