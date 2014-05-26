require 'spec_helper'

describe User do
  subject(:user) { build(:user) }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  context 'when email is not present' do
    before { user.email = nil }
    it { should_not be_valid }
  end

  context 'when email format is invalid' do
    it 'should be invalid' do
      adresses = %w(
        user@foo,com
        user_at_foo.org
        example.user@foo.
        foo@bar_baz.com
        foo@bar+baz.com
        foobar@exam..ple.com)
      adresses.each do |invalid_adress|
        user.email = invalid_adress
        expect(user).not_to be_valid
      end
    end
  end

  context 'when email format is valid' do
    it 'should be valid' do
      adresses = %w(
        user@foo.COM
        A_US-ER@f.b.org
        first.last@foo.jp
        a+b@baz.cn)
      adresses.each do |valid_adress|
        user.email = valid_adress
        expect(user).to be_valid
      end
    end
  end

  context 'when email adress is already taken' do
    let!(:user_with_same_email) { create(:user, email: user.email) }
    it { should_not be_valid }
  end

  context 'when password is not present' do
    before { user.password = nil }
    it { should_not be_valid }
  end

  context 'when password is too shot' do
    before { user.password = 'a' * 3 }
    it { should_not be_valid }
  end

  context 'when password is too long' do
    before { user.password = 'a' * 50 }
    it { should_not be_valid }
  end

  context 'when password confirmation is not present' do
    before { user.password_confirmation = nil }
    it { should_not be_valid }
  end

  context 'when password confirmation is not correct' do
    before { user.password_confirmation = 'qwerty' }
    it { should_not be_valid }
  end
end
