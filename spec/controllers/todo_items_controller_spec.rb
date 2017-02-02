require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
  describe "GET #new" do

    it "renders the new todo_items page" do
      get :new

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do

    context "with invalid params" do
      it "validates the presence of title" do
        post :create, todo_item: {title: ''}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to todo_item index page" do
        post :create, todo_item: {title: 'My New Todo Item'}
        expect(response).to redirect_to(todo_items_url)
      end
    end

  end

  describe "GET #edit" do
    let(:todo_item) { FactoryGirl.create(:todo_item) }

    it "renders the edit todo_items page" do
      get :edit, id: todo_item.id

      expect(response).to render_template("edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    before :each do
      @todo_item = FactoryGirl.create(:todo_item)
    end

    context "with invalid params" do
      it "validates the presence of title" do
        patch :update, id: @todo_item, todo_item: FactoryGirl.attributes_for(:todo_item, title: '')
        expect(response).to render_template("edit")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to todo_item show page" do
        patch :update, id: @todo_item, todo_item: FactoryGirl.attributes_for(:todo_item)
        expect(response).to redirect_to(todo_item_url(@todo_item))
      end
    end

  end

  describe "GET #show" do
    let(:todo_item) { FactoryGirl.create(:todo_item) }

    it "renders the todo_item show page" do
      get :show, id: todo_item.id

      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end

  end

  describe "DELETE #destroy" do
    before :each do
      @todo_item = FactoryGirl.create(:todo_item)
    end

    it "deletes the todo_item" do
      expect{
        delete :destroy, id: @todo_item
      }.to change(TodoItem, :count).by(-1)
    end

    it "redirects to todo_item index page" do
      delete :destroy, id: @todo_item
      expect(response).to redirect_to(todo_items_url)
    end

  end

  describe "GET #index" do
    before :each do
      @completed_todo_item = FactoryGirl.create(:todo_item, completed: true)
      @incomplete_todo_item = FactoryGirl.create(:todo_item)
    end

    it "renders the todo_item index page" do
      get :index

      expect(response).to render_template("index")
      expect(response).to have_http_status(200)
    end

    context 'without filtering' do
      it "retrieves all todo_items" do
        get :index
        expect(assigns(:todo_items)).to eq([@completed_todo_item, @incomplete_todo_item])
      end
    end

    context 'filter by incomplete' do
      it "retrieves only incomplete todo_items" do
        get :index, filtered: true
        expect(assigns(:todo_items)).to eq([@incomplete_todo_item])
      end
    end

  end
end
