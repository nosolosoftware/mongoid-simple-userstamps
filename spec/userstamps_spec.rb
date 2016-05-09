require 'spec_helper'

describe 'Mongoid::Userstamp' do
  class User
    include Mongoid::Document
    include Mongoid::Userstamps::User
  end

  class Post
    include Mongoid::Document
    include Mongoid::Userstamps::Model

    field :title
  end

  before :all do
    @user = User.create
    Mongoid::Userstamps::Config.set_current(@user)
  end

  context 'when include Mongoid::Userstamps::Model' do
    it 'add user stamps relations' do
      post = Post.new
      expect(post.created_by).to eq nil
      expect(post.updated_by).to eq nil
    end
  end

  context 'when create Post' do
    it 'should save user stamps relations' do
      post = Post.create
      expect(post.created_by).to eq(@user)
    end
  end

  context 'when update Post' do
    it 'should save user stamps relations' do
      post = Post.create
      post.title = "title"
      post.save
      expect(post.updated_by).to eq(@user)
    end
  end
end
