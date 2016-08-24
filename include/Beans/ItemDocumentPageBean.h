#pragma once

#include <iostream>
#include "Beans/DatabaseBean.h"

// an item document page bean, directly from the database
struct ItemDocumentPageBean : DatabaseBean {
	std::string item_id;
	int page_nr;
	std::string title;
	std::string content;
};