class CreatesPostTable < ActiveRecord::Migration
  def change
  create_table 'posts' do |p|
    p.integer :user
    p.text :content
    end
  end
end