require 'spec_helper'
require 'king_checks'

describe 'KingChecks' do
	before :each do
		@king_checks = KingChecks.new
	end

	describe '#initialize' do
		it 'creates an instance of queen when initiated' do
			expect(@king_checks).to be_an_instance_of(KingChecks)
		end

		it 'initializes with empty array move_history' do
			expect(@king_checks.check_path).to eql([])
		end	
	end
end