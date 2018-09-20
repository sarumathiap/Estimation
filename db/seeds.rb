# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


r22 = Release.create(name: "R22" , link: "v22.0.0")

Modul.create(name: "Analytics", jqllink: "Analytics" , release_id: r22.id );
Modul.create(name: "Application Platform",jqllink:"'Application%20Platform'", release_id: r22.id );
Modul.create(name: "Approvals",jqllink:"Approvals", release_id: r22.id );
Modul.create(name: "Catalogs",jqllink:"Catalogs", release_id: r22.id );
Modul.create(name: "Contract Collaboration",jqllink:"'Contract%20Collaboration'", release_id: r22.id );
Modul.create(name: "Data Insights",jqllink:"'Data%20Insights'", release_id: r22.id );
Modul.create(name: "Expenses",jqllink:"Expenses", release_id: r22.id );
Modul.create(name: "Integration Platform",jqllink:"'Integration%20Platform'", release_id: r22.id );
Modul.create(name: "Inventory",jqllink:"Inventory", release_id: r22.id );
Modul.create(name: "Invoicing - AP Automation",jqllink:"'Invoicing%20-%20AP%20Automation'", release_id: r22.id );
Modul.create(name: "Invoicing - Compliance",jqllink:"'Invoicing%20-%20Compliance'", release_id: r22.id );
Modul.create(name: "Invoicing - Core",jqllink:"'Invoicing%20-%20Core'", release_id: r22.id );
Modul.create(name: "Mobile" , jqllink: "Mobile", release_id: r22.id);
Modul.create(name: "Payment",jqllink:"Payment", release_id: r22.id);
Modul.create(name: "Performance",jqllink:"Performance", release_id: r22.id );
Modul.create(name: "Procurement",jqllink:"Procurement", release_id: r22.id );
Modul.create(name: "Sourcing",jqllink:"Sourcing", release_id: r22.id );
Modul.create(name: "Sourcing Optimization",jqllink:"'Sourcing%20Optimization'", release_id: r22.id );
Modul.create(name: "Supplier",jqllink:"Supplier", release_id: r22.id );
Modul.create(name: "Technology Platform",jqllink: "'Technology%20Platform'", release_id: r22.id );
Modul.create(name: "UX",jqllink:"Ux", release_id: r22.id );






Hardcode.create(name: "versioncheck" , hardcodedata: "https://coupadev.atlassian.net/rest/api/2/search?jql=Project%20in%20(CD)%20AND%20(affectedVersion%20in%20(versioncheck)%20AND%20'Target%20Release'%20is%20EMPTY%20OR%20'Target%20Release'%20in%20(versioncheck))%20AND%20issuetype%20%3D%20Epic%20AND%20'Dev%20Team'%20%3D%20")
Hardcode.create(name: "epiclink" , hardcodedata: "https://coupadev.atlassian.net/rest/api/2/search?jql=project%20%3D%20CD%20AND%20issuetype%20%3D%20Story%20AND%20'Epic%20Link'%20%3D")
Hardcode.create(name:"epicuilink" , hardcodedata: "https://coupadev.atlassian.net/browse/")


Sidekiqjob.create(jobid: "jasdjsjd" , start_progess: "started" , end_progress: "completed")

User.create(email: "demo1@coupa.com" , role: "admin" , status: "1")

i=Info.new(username: "girija.govindharaj@coupa.com" , password: "welcome123")
i.save
# r21 = Release.create(name: "R21")
# r20 = Release.create(name: "R20")

# Modul.create(name:"Analytics" , release_id: r21.id)
# Modul.create(name:"App" , release_id: r21.id)
# Modul.create(name:"catlog" , release_id: r21.id)

# Modul.create(name:"payment" , release_id: r20.id)
# Modul.create(name:"mobile" , release_id: r20.id)
# Modul.create(name:"supplier" , release_id: r20.id)

