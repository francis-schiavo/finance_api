# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'should create person' do
    person = Person.new(name: 'John', last_name: 'Doe', birthday: '1990-01-01')

    assert person.save
  end

  test 'should not create person without name' do
    person = Person.new(last_name: 'Doe', birthday: '1990-01-01')

    assert_not person.save
  end

  test 'should not create person without last name' do
    person = Person.new(name: 'John', birthday: '1990-01-01')

    assert_not person.save
  end

  test 'should not create person without birthday' do
    person = Person.new(name: 'John', last_name: 'Doe')

    assert_not person.save
  end

  test 'should update person' do
    person = people(:john)

    person.name = 'Johnny'

    assert person.save
  end

  test 'should destroy person' do
    person = people(:deletable)

    assert person.destroy
  end
end
