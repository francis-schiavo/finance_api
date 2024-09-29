# frozen_string_literal: true

require 'test_helper'

class TerminalTest < ActiveSupport::TestCase
  test 'should create terminal' do
    terminal = Terminal.new(alias: 'terminal three')

    assert terminal.save
  end

  test 'should not create terminal without alias' do
    terminal = Terminal.new

    assert_not terminal.save
  end

  test 'should not create terminal with duplicate alias' do
    Terminal.create(alias: 'Terminal four')
    terminal = Terminal.new(alias: 'Terminal four')

    assert_not terminal.save
  end

  test 'should not delete terminal' do
    terminal = terminals(:deletable)

    assert_raise ActiveRecord::ReadOnlyRecord do
      terminal.destroy
    end

    assert_raise ActiveRecord::ReadOnlyRecord do
      terminal.destroy!
    end
  end
end
