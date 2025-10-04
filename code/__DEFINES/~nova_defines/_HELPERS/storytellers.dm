#define LOG_CATEGORY_STORYTELLER "storyteller"
#define LOG_CATEGORY_STORYTELLER_PLANNER "storyteller_planner"
#define LOG_CATEGORY_STORYTELLER_ANALYZER "storyteller_analyzer"
#define LOG_CATEGORY_STORYTELLER_BALANCER "storyteller_balancer"
#define LOG_CATEGORY_STORYTELLER_METRICS "storyteller_metrics"

/proc/log_storyteller(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER, text, data)

/proc/log_storyteller_planner(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_PLANNER, text, data)

/proc/log_storyteller_analyzer(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_ANALYZER, text, data)

/proc/log_storyteller_balancer(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_BALANCER, text, data)

/proc/log_storyteller_metrics(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_METRICS, text, data)

