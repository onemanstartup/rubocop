# encoding: utf-8

require 'spec_helper'

module Rubocop
  module Cop
    module Lint
      describe EnsureReturn do
        let(:er) { EnsureReturn.new }

        it 'registers an offence for return in ensure' do
          inspect_source(er,
                         ['begin',
                          '  something',
                          'ensure',
                          '  file.close',
                          '  return',
                          'end'])
          expect(er.offences.size).to eq(1)
          expect(er.offences.map(&:message))
            .to eq([EnsureReturn::MSG])
        end

        it 'does not register an offence for return outside ensure' do
          inspect_source(er,
                         ['begin',
                          '  something',
                          '  return',
                          'ensure',
                          '  file.close',
                          'end'])
          expect(er.offences).to be_empty
        end

        it 'does not check when ensure block has no body' do
          expect do
            inspect_source(er,
                           ['begin',
                            '  something',
                            'ensure',
                            'end'])
          end.to_not raise_exception

        end
      end
    end
  end
end
