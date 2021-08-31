require 'spec_helper'
require_relative '../cipher'

RSpec.describe 'Cipher' do
    describe 'caesar_cipher' do
        it 'encrypts' do
            expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!")
        end
    end

    describe 'caesar_cipher' do
        it 'encrypts' do
            expect(caesar_cipher("What a string!", 0)).to eq("What a string!")
        end
    end

    describe 'caesar_cipher' do
        it 'encrypts' do
            expect(caesar_cipher("-----", 7)).to eq("-----")
        end
    end
end