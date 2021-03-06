require 'spec_helper'

try_spec do
  describe Ardm::Property::BCryptHash do
    before do
      @clear_password   = 'Ardm R0cks!'
      @crypted_password = BCrypt::Password.create(@clear_password)

      @nonstandard_type = 1

      class ::TestType
        @a = 1
        @b = 'Hi There'
      end
      @nonstandard_type2 = TestType.new

      class ::User < Ardm::Record
        property :id, Serial
        property :password, BCryptHash
      end

      @bcrypt_hash = User.properties[:password]
    end

    describe '.dump' do
      describe 'when argument is a string' do
        before do
          @input  = 'Ardm'
          @result = @bcrypt_hash.dump(@input)
        end

        it 'returns instance of BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'returns a string that is 60 characters long' do
          expect(@result.size).to eq(60)
        end
      end

      describe 'when argument is nil' do
        before do
          @input  = nil
          @result = @bcrypt_hash.dump(@input)
        end

        it 'returns nil' do
          expect(@result).to be_nil
        end
      end
    end

    describe '.load' do
      describe 'when argument is a string' do
        before do
          @input  = 'Ardm'
          @result = @bcrypt_hash.load(@crypted_password)
        end

        it 'returns instance of BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'returns a string that matches original' do
          expect(@result).to eq(@clear_password)
        end
      end

      describe 'when argument is nil' do
        before do
          @input  = nil
          @result = @bcrypt_hash.load(@input)
        end

        it 'returns nil' do
          expect(@result).to be_nil
        end
      end
    end

    describe '.typecast' do
      describe 'when argument is a string' do
        before do
          @input  = 'bcrypt hash'
          @result = @bcrypt_hash.typecast(@input)
        end

        it 'casts argument to BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'casts argument to value that matches input' do
          expect(@result).to eq(@input)
        end
      end

      describe 'when argument is a blank string' do
        before do
          @input  = ''
          @result = @bcrypt_hash.typecast(@input)
        end

        it 'casts argument to BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'casts argument to value that matches input' do
          expect(@result).to eq(@input)
        end
      end

      describe 'when argument is integer' do
        before do
          @input  = 2249
          @result = @bcrypt_hash.typecast(@input)
        end

        it 'casts argument to BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'casts argument to value that matches input' do
          expect(@result).to eq(@input)
        end
      end

      describe 'when argument is hash' do
        before do
          @input  = { :cryptic => 'obscure' }
          @result = @bcrypt_hash.typecast(@input)
        end

        it 'casts argument to BCrypt::Password' do
          expect(@result).to be_an_instance_of(BCrypt::Password)
        end

        it 'casts argument to value that matches input' do
          expect(@result).to eq(@input)
        end
      end

      describe 'when argument is nil' do
        before do
          @input  = nil
          @result = @bcrypt_hash.typecast(@input)
        end

        it 'returns nil' do
          expect(@result).to be_nil
        end
      end
    end
  end
end
