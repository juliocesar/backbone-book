* Views watch the data layer, and display it. Views don't have data except through the data layer. If yours do, you're making a mistake.
* Stepping out of the model-change-rerender-view pattern that may be warranted at times, but it comes at a price: more complexity. If you consider rendering a template is cheap memory/CPU-wise, it's rarely worth it.
