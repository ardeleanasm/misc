package com.ars.parser;

import javax.xml.stream.StreamFilter;
import javax.xml.stream.XMLStreamReader;

public class CompanyFilter implements StreamFilter {
	private boolean accept=true;
	private String tag;
	private String value;
	
	public CompanyFilter setTag(String tag) {
		this.tag=tag;
		return this;
	}
	
	public CompanyFilter setValue(String value) {
		this.value=value;
		return this;
	}
	
	
	
	public boolean accept(XMLStreamReader reader) {
		 if(reader.isStartElement() && tag.equals(reader.getLocalName())) {
	            accept = "abc".equals(reader.getAttributeValue(null, value));
	        } else if(reader.isEndElement()) {
	            boolean returnValue = accept;
	            accept = true;
	            return returnValue;
	        }
	        return accept;
	    }
}
