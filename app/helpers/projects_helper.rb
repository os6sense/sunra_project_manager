module ProjectsHelper
#  def show_button (project)
#    link_to t('.show',
#      :default => t("helpers.links.show")),
#      polymorphic_path([project]),
#      :class => 'btn btn-mini btn-primary'
#  end

#  def edit_button (project)
#    link_to t('.edit',
#      :default => t("helpers.links.edit")),
#      edit_polymorphic_path([project]),
#      :class => 'btn btn-mini btn-warning'
#  end

#  def destroy_button (project)
#    link_to t('.destroy', :default => t("helpers.links.destroy_project")),
#      polymorphic_path([project]), :method => :delete,
#      :data => { :confirm => t('.confirm',
#      :default => t("helpers.links.confirm",
#      :default => 'Are you sure?')) },
#      :class => 'btn btn-mini btn-danger'
#  end

# # def project_controls(project)
#    "#{show_button(project)} #{edit_button(project)} #{destroy_button(project)}"
#  end
end
