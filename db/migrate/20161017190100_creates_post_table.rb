class CreatesPostTable < ActiveRecord::Migration
  def change
  create_table 'posts' do |p|
    p.text :content
    end
  end
end