class CreateComments < ActiveRecord::Migration
  def change
  	#create table takes Symbol arg :comments and block argumnent 
  	#that contains details to be added to the table
    create_table :comments do |t|
      t.text :body
      #tells database to index postid column 
      #added automatically when ggenerate reference argument
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
