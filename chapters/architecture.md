# Overview and bullshit-dispelling.

## The lot

* You have models, views (or controllers, name it as you will), and URLs. As is with nearly every other popular and decent framework/lib of this kind.
* Models and collections are your data layer. Given what the user does is create/change/delete data, this is where the real action is.
* Views watch the data layer, and display it. Views don't have data except through the data layer. If yours do, you're making a mistake.
* URLs, when triggered, will call functions via your router. These functions will load data by getting the data layer to fetch it from somewhere, and give said data to one or more views to render.
* The rule of thumb is get the hell away from the DOM. You won't read from it ever, since your data layer knows what has what value. You'll write to the DOM only by rendering views.
* Small modules that live outside of Backbone's triad (read: are not a model/view/router) **are ok**. So long as they perform **one** function and are clear in what they in turn require, it's all good.
* Common architecture mistakes involve in getting one or more of the previous statements wrong, "bending the rules a little", or however else you excuse it.
* This is what every well architected app does: they get views to track changes in data, and re-render the associated view(s) in more or less granular fashion depending on the tool (Angular for instance would be very granular by default).
* It's entirely possible to make stupid mistakes with every framework. To say one is less prone to idiocy than the other is a cheap attempt at misguiding you. As is stupid to say framework X "does URLs well" (it either does or it doesn't).
* The ultimate goal is creating a fast, beautiful, and maintainable build, and that's achieved by doing things right through the entire stack (HTML and CSS too), as well as great design, not just the application logic. There's no tool for going around that. Citing an app as evidence of a framework "being better" conveniently leaves this out, which means it's also an attempt at misguiding you.
* Pick a tool and go with it. Stop asking questions like "Is Angular better than Backbone?". It's a huge waste of time even thinking about it until you're well into a handful of apps and made **a lot** of mistakes which you learned from.
* You can bend Backbone to your will once you mastered it. A lot of projects out there consist of patterns built on top of it. Though fact is, most of the time you'll get away with not doing any of that.
* Think twice, or actually, three times before adding a plugin. It doesn't matter how awesome your favourite website says it is, or how many followers the author has on Twitter. Hell is other people's code, and the way to it is paved by assumptions that shit just works.
