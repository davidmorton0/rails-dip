# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  subject { Class.new.extend described_class }

  describe '#full_title' do
    context 'when a page title is provided' do
      it 'returns the full page title' do
        expect(subject.full_title('Page')).to eq 'Page | Rails Diplomacy'
      end
    end

    context 'when no page title is provided' do
      it 'returns the default page title' do
        expect(subject.full_title).to eq 'Rails Diplomacy'
      end
    end
  end
end
