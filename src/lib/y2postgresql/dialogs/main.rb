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

Yast.import "UI"
Yast.import "Label"

module Y2Postgresql
  module Dialogs
    # Dialog allowing the user to configure some server settings and to
    # manage databases.
    class Main
      include Yast::UIShortcuts
      include Yast::I18n
      include Yast::Logger

      def initialize
        textdomain "postgresql"
      end

      # Displays the dialog and handles user input until the dialog is closed
      def run
        return unless create_dialog

        begin
          return event_loop
        ensure
          close_dialog
        end
      end

    private

      # Simple event loop
      def event_loop
        loop do
          input = Yast::UI.UserInput
          # Break the loop
          break if input == :cancel

          log.warn "Unexpected input #{input}"
        end
      end

      def close_dialog
        Yast::UI.CloseDialog
      end

      def create_dialog
        Yast::UI.OpenDialog(
          Opt(:defaultsize),
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
        )
      end

      def databases_table
        Table(
          Id(:databases_table),
          Header(_("Name"), _("Owner")),
          [
            Item(Id(:db1), "Database 1", "postgres"),
            Item(Id(:db2), "Database 2", "postgres")
          ]
        )
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
