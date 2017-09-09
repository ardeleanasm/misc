package com.ars.parser;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStream;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import com.ars.generated.Company;

public class XmlManager {
	private String			path;
	private JAXBContext		context;
	private Unmarshaller	unmarshaller;

	public XmlManager(String path) {
		this.path = path;
	}

	public XmlManager initialize() throws JAXBException {
		context = JAXBContext.newInstance(Company.class);
		unmarshaller = context.createUnmarshaller();
		return this;
	}

	public void writeXml() {

	}

	public Object readXml() throws Exception {
		verifyInitialization();
		return readFromFile();
	}

	public Object readTagValue(String entityName,String attribute, String value)
	        throws FileNotFoundException, XMLStreamException, JAXBException {
		XMLInputFactory xif = XMLInputFactory.newInstance();
		XMLStreamReader xsr = xif.createXMLStreamReader(new FileInputStream(path));
		xsr = xif.createFilteredReader(xsr, new CompanyFilter().setEntityName(entityName).setFilterValues(attribute,value));
		return readFromStream(xsr);
	}

	private void verifyInitialization() throws Exception {
		if (context == null || unmarshaller == null) {
			throw new Exception("Unitialized object!");
		}
	}

	private Object readFromFile() throws FileNotFoundException, JAXBException {
		return unmarshaller.unmarshal(new FileReader(path));
	}

	private Object readFromStream(XMLStreamReader xsr) throws JAXBException {
		return unmarshaller.unmarshal(xsr);
	}
}
