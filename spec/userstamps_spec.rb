require 'spec_helper'

describe 'Mongoid::Userstamp' do
  class User
    include Mongoid::Document
  end

  class Post
    include Mongoid::Document
    include Mongoid::Userstamps::Model

    field :title
  end

  context 'when current is defined' do
    before :all do
      @user = User.create
      Mongoid::Userstamps::User.current = @user
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

      it 'should not overwrite created_by' do
        user = User.create
        post = Post.create(created_by: user)
        expect(post.created_by).to eq(user)
      end
    end

    context 'when update Post' do
      it 'should save user stamps relations' do
        post = Post.create
        post.update(title: 'title')
        expect(post.updated_by).to eq(@user)
      end

      it 'should not overwrite updated_by when it changes' do
        user = User.create
        post = Post.create
        post.update(title: 'title', updated_by: user)
        expect(post.updated_by).to eq(user)
      end

      it 'should not overwrite updated_by when use skip_userstamps' do
        user = User.create
        post = Post.create(updated_by: user)
        post.skip_userstamps.update(title: 'title')
        expect(post.updated_by).to eq(user)

        # after saved skip is removed
        post.update(title: 'new_title')
        expect(post.updated_by).to eq(@user)
      end
    end

    context 'when check thread safe' do
      it 'works' do
        Post.destroy_all
        user1 = User.create
        user2 = User.create

        Thread.start do
          Mongoid::Userstamps::User.current = user1
          sleep 0.2
          Post.create
        end

        Thread.start do
          sleep 0.1
          Mongoid::Userstamps::User.current = user2
        end

        sleep 0.3
        expect(Post.first.created_by).to eq(user1)
      end
    end
  end

  context 'when current is not defined' do
    before :all do
      Mongoid::Userstamps::User.current = nil
    end

    it 'should not set created_by' do
      post = Post.create
      expect(post.created_by).to be_nil
    end

    it 'should not set updated_by' do
      post = Post.create
      post.update_attributes(title: 'title')
      expect(post.updated_by).to be_nil
    end

    context 'when set manually created_by' do
      it 'should respect it' do
        user = User.create
        post = Post.create(created_by: user)
        expect(post.created_by).to eq(user)
      end
    end
  end
end
