First step
==========

Let's take a look to your brand new module.

The `src` directory:

 * No `modules` directory.
   * The reign of the YCP modules is coming to an end.
   * Long live objects!
 * The traditional `clients` directory.
   * Very lightweight "scripts".
   * Instantiate some testable object and ask it to do the job.
 * The `lib` directory:
   * A nice home for all the OOP code to live in peace and harmony following
     Ruby conventions.
   * Code organized into `Y2Whatever` namespaces
     * `require "y2whatever"` should be enough to make all the utility domain
       classes available
     * Well-known sub-namespaces like `clients`, `dialogs`, etc.

The `test` directory:
  * RSpec tests honoring the file structure in `lib`

Second step
===========

Using the power of OOP to write sane dialogs.

[UI::Dialog
documentation](http://www.rubydoc.info/github/yast/yast-yast2/UI/Dialog)

Third step
==========

Let's implement creation and deletion of databases using the command line
instead of a PostgreSQL Ruby gem (which would be the smarter solution).

The commands:
 * Get databases: `su -c "psql --list" postgres`
 * Create database: `su -c "createdb [NAME] -O [OWNER]" postgres`
 * Delete database: `su -c "dropdb [NAME]" postgres`

We will make use of `Yast::Execute` (see
[documentation](http://www.rubydoc.info/github/yast/yast-yast2/Yast/Execute)),
which is based on [Cheetah](https://github.com/openSUSE/cheetah). So let's
talk about Cheetah.

Don't forget the RSpec tests and the changelog entry!

Fourth step (optional)
======================

Adding a widget to start/stop the PostgreSQL service.

That can be done by relying on the classes provided by the basic YaST
libraries (the `yast2` package).

[The `UI::ServiceStatus` class](http://www.rubydoc.info/github/yast/yast-yast2/UI/ServiceStatus)

[The SystemdService platypus](http://www.rubydoc.info/github/yast/yast-yast2/Yast/SystemdServiceClass)

Add a nice changelog entry!

Last but not least
==================

Let's use CFA to access and modify the PostgreSQL configuration.

**Josef, this is for you!!!**
