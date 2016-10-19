class CreatesPostTable < ActiveRecord::Migration
  def change
  create_table 'posts' do |p|
    p.integer :id
    p.text :content
    p.integer :user_id
    end
  end
end