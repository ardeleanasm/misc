package com.ars.parser;

import javax.xml.stream.StreamFilter;
import javax.xml.stream.XMLStreamReader;

public class CompanyFilter implements StreamFilter {
	private boolean accept=true;
	private String tag;
	private String value;
	private String attribute;
	public CompanyFilter setEntityName(String entityName) {
		this.tag=entityName;
		return this;
	}
	
	public CompanyFilter setFilterValues(String attribute,String value) {
		this.value=value;
		this.attribute=attribute;
		return this;
	}
	
	
	
	
	public boolean accept(XMLStreamReader reader) {
		 if(reader.isStartElement() && tag.equals(reader.getLocalName())) {
	            accept = value.equals(reader.getAttributeValue(null, attribute));
	        } else if(reader.isEndElement()) {
	            boolean returnValue = accept;
	            accept = true;
	            return returnValue;
	        }
	        return accept;
	    }
}
