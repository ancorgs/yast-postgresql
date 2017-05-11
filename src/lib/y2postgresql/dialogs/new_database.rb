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

Yast.import "UI"
Yast.import "Label"

module Y2Postgresql
  module Dialogs
    # Simple form to collect the minimal information needed to create a database
    class NewDatabase < UI::Dialog
      def initialize
        textdomain "postgresql"
      end

      def dialog_content
        VBox(
          InputField(Id(:name), _("Name"), ""),
          InputField(Id(:owner), _("Owner"), ""),
          VSpacing(1),
          HBox(
            PushButton(Id(:cancel), Yast::Label.CancelButton),
            PushButton(Id(:accept), Yast::Label.AcceptButton)
          )
        )
      end

      def accept_handler
        name = Yast::UI.QueryWidget(Id(:name), :Value)
        owner = Yast::UI.QueryWidget(Id(:owner), :Value)
        database =
          if name.empty? || owner.empty?
            nil
          else
            Database.new(name, owner, exists: false)
          end

        finish_dialog(database)
      end

      def cancel_handler
        finish_dialog(nil)
      end
    end
  end
end
