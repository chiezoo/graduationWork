ActiveAdmin.register User do
  filter :email
  filter :admin
  filter :created_at

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :admin
    end
    f.actions
  end

  permit_params :email, :password, :password_confirmation, :admin
end
