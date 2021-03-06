require 'spec_helper'

describe Ardm::Property::Binary do
  before do
    @name          = :title
    @type          = described_class
    @load_as     = String
    @value         = 'value'
    @other_value   = 'return value'
    @invalid_value = 1
  end

  it_should_behave_like 'A public Property'

  describe '.options' do
    subject { described_class.options }

    it { is_expected.to be_kind_of(Hash) }

    it { is_expected.to eql(:load_as => @load_as, :dump_as => @load_as, :coercion_method => :to_string, :length => 50) }
  end

  if RUBY_VERSION >= "1.9"
    describe 'encoding' do
      let(:model) do
        Class.new(::Ardm::Record) do
          self.table_name = "articles" # co-opt the articles table
          property :bin_data, ::Ardm::Property::Binary, :field => 'body'
        end
      end

      it 'should always dump with BINARY' do
        expect(model.properties[:bin_data].dump("foo".freeze).encoding.names).to include("BINARY")
      end

      it 'should always load with BINARY' do
        expect(model.properties[:bin_data].load("foo".freeze).encoding.names).to include("BINARY")
      end
    end
  end
end
