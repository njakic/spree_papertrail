module PaperTrail
  Model.module_eval do
    # Entrega la version con los datos actuales
    #  - Si no hay una version actual la construye
    #  - La version actual es la que fue creada despues de la fecha de actualizacion del objeto trackeado
    def current_version
      # Reviso si hay alguna version actual
      timestamp = respond_to?(:updated_at) ? updated_at : DateTime.now

      cv = send(self.class.versions_association_name).where("#{PaperTrail.timestamp_field} > :last_update", last_update: timestamp).last

      return cv if cv


      # Dado que no existe una version actual vamos a crear una y retornarla
      object_attrs = object_attrs_for_paper_trail(item_before_change)

      data = {
        :event     => paper_trail_event || 'update',
        :object    => self.class.paper_trail_version_class.object_col_is_json? ? object_attrs : PaperTrail.serializer.dump(object_attrs),
        :whodunnit => PaperTrail.whodunnit
      }

      data[PaperTrail.timestamp_field] = DateTime.now

      if self.class.paper_trail_version_class.column_names.include?('object_changes')
        data[:object_changes] = self.class.paper_trail_version_class.object_changes_col_is_json? ? changes_for_paper_trail :
          PaperTrail.serializer.dump(changes_for_paper_trail)
      end

      cv = send(self.class.versions_association_name).create merge_metadata(data)

      return cv
    end

    # Entrega el :id del la version con los datos actuales
    def current_version_id
      current_version.id
    end
  end
end
