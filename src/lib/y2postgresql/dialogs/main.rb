# Copyright (c) 2017 SUSE LLC.
#  All Rights Reserved.

#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 or 3 of the GNU General
#  Public License as published by the Free Software Foundation.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program; if not, contact SUSE LLC.

#  To contact Novell about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com

require "yast"
require "ui/dialog"
require "y2postgresql"
require "y2postgresql/dialogs/new_database"

Yast.import "UI"
Yast.import "Label"

module Y2Postgresql
  module Dialogs
    # Dialog allowing the user to configure some server settings and to
    # manage databases.
    class Main < UI::Dialog
      def initialize
        textdomain "postgresql"

        @databases = DatabasesList.new_from_system
      end

      def dialog_options
        Opt(:defaultsize)
      end

      def dialog_content
        VBox(
          Heading(_("Server settings")),
          InputField(Id(:port), Opt(:hstretch), _("Port"), "5432"),
          IntField(Id(:max_connections), _("Max number of connections"), 1, 999999, 100),
          Heading(_("Databases")),
          HBox(
            databases_table,
            VBox(
              PushButton(Id(:add_database), _("Add")),
              PushButton(Id(:del_database), _("Delete"))
            )
          ),
          VSpacing(1),
          footer
        )
      end

      def accept_handler
        @databases.write_to_system
        finish_dialog
      end

      def add_database_handler
        database = NewDatabase.run
        @databases.add(database) if database
        redraw_table
      end

      def del_database_handler
        name = Yast::UI.QueryWidget(Id(:databases_table), :CurrentItem)
        @databases.delete(name)
        redraw_table
      end

    private

      def databases_table
        Table(
          Id(:databases_table),
          Header(_("Name"), _("Owner")),
          database_items
        )
      end

      def database_items
        @databases.map do |db|
          Item(Id(db.name), db.name, db.owner)
        end
      end

      def redraw_table
        Yast::UI.ChangeWidget(Id(:databases_table), :Items, database_items)
      end

      def footer
        HBox(
          HSpacing(),
          Left(PushButton(Id(:help), Opt(:key_F1, :help), Yast::Label.HelpButton)),
          PushButton(Id(:cancel), Yast::Label.CancelButton),
          PushButton(Id(:accept), Yast::Label.AcceptButton),
          HSpacing()
        )
      end
    end
  end
end
