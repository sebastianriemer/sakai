<!--
* $Id$
<%--
***********************************************************************************
*
* Copyright (c) 2004, 2005, 2006 The Sakai Foundation.
*
* Licensed under the Educational Community License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.osedu.org/licenses/ECL-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License. 
*
**********************************************************************************/
--%>
-->
<h:dataTable id="TreeTable" cellpadding="0" cellspacing="0" value="#{questionpool.sortedSubqpools}"
	 var="pool" styleClass="listHier" >

    <h:column id="col1">
     <f:facet name="header">
      <h:panelGroup>
       <h:commandLink title="#{questionPoolMessages.t_sortTitle}" id="sortByTitle" immediate="true" rendered="#{questionpool.sortSubPoolProperty ne 'title'}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <f:param name="subPoolOrderBy" value="title"/>
          <f:param name="subPoolAscending" value="true"/>
          <h:outputText value="#{questionPoolMessages.p_name}" rendered="#{questionpool.sortSubPoolProperty ne 'title'}" />
       </h:commandLink>
      
       <h:commandLink title="#{questionPoolMessages.t_sortTitle}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'title' and questionpool.sortSubPoolAscending eq true}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <h:outputText value="#{questionPoolMessages.p_name}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'title'}" />
          <f:param name="subPoolOrderBy" value="title"/>
          <f:param name="subPoolAscending" value="false" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortTitleDescending}" rendered="#{questionpool.sortSubPoolAscending eq true}" url="/images/sortascending.gif"/>
      </h:commandLink>
      <h:commandLink title="#{questionPoolMessages.t_sortTitle}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'title' and questionpool.sortSubPoolAscending eq false}" action="#{questionpool.sortSubPoolByColumnHeader}">
           <h:outputText value="#{questionPoolMessages.p_name}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'title'}" />
          <f:param name="subPoolOrderBy" value="title"/>
          <f:param name="subPoolAscending" value="true" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortTitleAscending}" rendered="#{questionpool.sortSubPoolAscending eq false}" url="/images/sortdescending.gif"/>
      </h:commandLink>
     </h:panelGroup>
     </f:facet>

<h:panelGroup styleClass="tier#{questionpool.tree.currentLevel-questionpool.parentPoolSize-1}" id="firstcolumn">
<h:inputHidden id="rowid" value="#{questionpool.tree.currentObjectHTMLId}"/>

<h:outputLink title="#{questionPoolMessages.t_toggletree}" id="parenttogglelink" onclick="toggleRows(this)" value="#" styleClass="treefolder" rendered="#{questionpool.tree.hasChildList eq true}" >
<h:graphicImage alt="#{questionPoolMessages.alt_togglelink}" id="spacer_for_mozilla" style="border:0" height="14" width="30" value="/images/delivery/spacer.gif" />
</h:outputLink>

<h:outputLink title="#{questionPoolMessages.t_toggletreeEmpty}" id="togglelink" value="#" styleClass="treedoc" rendered="#{questionpool.tree.hasNoChildList eq true}" >
<h:graphicImage id="spacer_for_mozilla1" style="border:0" width="30" height="14" value="/images/delivery/spacer.gif" />
</h:outputLink>


<h:commandLink title="#{questionPoolMessages.t_editPool}" id="editlink" immediate="true" action="#{questionpool.editPool}">
  <h:outputText id="poolnametext" value="#{pool.displayName}" escape="false"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
</h:commandLink>

<f:verbatim><br/></f:verbatim>
<h:graphicImage id="spacer" style="border:0" height="14" width="30" value="/images/delivery/spacer.gif" />
 <f:verbatim><span class="itemAction"></f:verbatim>

<!-- Add SubPools -->
<h:commandLink title="#{questionPoolMessages.t_addSubpool}" rendered="#{questionpool.importToAuthoring eq false and pool.canAddPools eq true}" id="addlink" immediate="true" action="#{questionpool.addPool}"> 
  <h:outputText id="add" value="#{questionPoolMessages.t_addSubpool}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
  <f:param name="outCome" value="editPool"/>
</h:commandLink>

<h:outputText rendered="#{questionpool.importToAuthoring eq false and pool.canCopyPools eq true and pool.canAddPools eq true}" value=" #{questionPoolMessages.separator} " />

<!-- Copy Pool -->
<h:commandLink title="#{questionPoolMessages.t_copyPool}" rendered="#{questionpool.importToAuthoring eq false and pool.canCopyPools eq true}" id="copylink" immediate="true" action="#{questionpool.startCopyPool}">
  <h:outputText id="copy" value="#{questionPoolMessages.copy}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
  <f:param name="outCome" value="editPool"/>
</h:commandLink>
<h:outputText rendered="#{questionpool.importToAuthoring eq false and pool.canMovePools eq true and pool.canCopyPools eq true}" value=" #{questionPoolMessages.separator} " />

<!-- Move Pool -->
<h:commandLink title="#{questionPoolMessages.t_movePool}" rendered="#{questionpool.importToAuthoring eq false and pool.canMovePools eq true}" id="movelink" immediate="true" action="#{questionpool.startMovePool}">
  <h:outputText id="move" value="#{questionPoolMessages.move}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
  <f:param name="outCome" value="editPool"/>
</h:commandLink>
<%--
<h:outputText rendered="#{questionpool.importToAuthoring eq false}" value=" #{questionPoolMessages.separator} " />
<h:commandLink rendered="#{questionpool.importToAuthoring eq false}" id="exportlink" immediate="true" action="#{questionpool.exportPool}">
  <h:outputText id="export" value="#{commonMessages.export_action}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
</h:commandLink>
--%>

<!-- Remove Pool -->
<h:outputText rendered="#{questionpool.importToAuthoring eq false and pool.canDeletePools eq true and pool.canMovePools eq true}" value=" #{questionPoolMessages.separator} " />
<h:commandLink title="#{questionPoolMessages.t_removePool}" rendered="#{questionpool.importToAuthoring eq false and pool.canDeletePools eq true}" id="removelink" immediate="true" action="#{questionpool.confirmRemovePool}">
  <h:outputText id="remove" value="#{commonMessages.remove_action}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
  <f:param name="outCome" value="editPool"/>
</h:commandLink>

<!-- Preview Pool -->
<h:outputText rendered="#{questionpool.importToAuthoring eq false and pool.canPreviewQuestions eq true}" value=" #{questionPoolMessages.separator} " />
<h:commandLink title="#{questionPoolMessages.t_previewPool}" rendered="#{questionpool.importToAuthoring eq false and pool.canPreviewQuestions eq true}" id="previewlink" immediate="true" action="#{questionpool.startPreviewPool}">
  <h:outputText id="preview" value="#{questionPoolMessages.preview}"/>
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
</h:commandLink>

<%-- Export Pool --%>
<h:outputText rendered="#{questionpool.importToAuthoring eq false}" value=" #{questionPoolMessages.separator} " />
<h:commandLink title="#{questionPoolMessages.t_exportPool}" rendered="#{questionpool.importToAuthoring eq false}" action="#{questionpool.startExportPool}" >
  <h:outputText id="export" value="#{questionPoolMessages.t_exportPool}"/>
  <f:param name="action" value="exportPool" />
  <f:param name="qpid" value="#{pool.questionPoolId}"/>
  <f:param name="outCome" value="editPool"/>
</h:commandLink>

 <f:verbatim></span></f:verbatim>

</h:panelGroup>
    </h:column>
    <h:column id="col2">
     <f:facet name="header">
    <h:panelGroup>
       <h:commandLink title="#{questionPoolMessages.t_sortCreator}" id="sortByOwner" immediate="true" rendered="#{questionpool.sortSubPoolProperty ne 'ownerId'}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <f:param name="subPoolOrderBy" value="ownerId"/>
          <f:param name="subPoolAscending" value="true"/>
          <h:outputText value="#{questionPoolMessages.creator}" rendered="#{questionpool.sortSubPoolProperty ne 'ownerId'}" />
       </h:commandLink>
      
       <h:commandLink title="#{questionPoolMessages.t_sortCreator}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'ownerId' and questionpool.sortSubPoolAscending eq true}" action="#{questionpool.sortSubPoolByColumnHeader}">
           <h:outputText value="#{questionPoolMessages.creator}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'ownerId'}" />
          <f:param name="subPoolOrderBy" value="ownerId"/>
          <f:param name="subPoolAscending" value="false" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortCreatorDescending}" rendered="#{questionpool.sortSubPoolAscending eq true}" url="/images/sortascending.gif"/>
      </h:commandLink>
      <h:commandLink title="#{questionPoolMessages.t_sortCreator}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'ownerId' and questionpool.sortSubPoolAscending eq false}" action="#{questionpool.sortSubPoolByColumnHeader}">
           <h:outputText value="#{questionPoolMessages.creator}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'ownerId'}" />
          <f:param name="subPoolOrderBy" value="ownerId"/>
          <f:param name="subPoolAscending" value="true" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortCreatorAscending}" rendered="#{questionpool.sortSubPoolAscending eq false}" url="/images/sortdescending.gif"/>
      </h:commandLink>
     </h:panelGroup>
     </f:facet>
     <h:panelGroup id="secondcolumn">
        <h:outputText value="#{pool.ownerDisplayName}"/>
     </h:panelGroup>
    </h:column>

    <h:column id="col3">
     <f:facet name="header">
      <h:panelGroup>
       <h:commandLink title="#{questionPoolMessages.t_sortLastModified}" id="sortByLastModified" immediate="true" rendered="#{questionpool.sortSubPoolProperty ne 'lastModified'}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <f:param name="subPoolOrderBy" value="lastModified"/>
          <f:param name="subPoolAscending" value="true"/>
          <h:outputText value="#{questionPoolMessages.last_mod}" rendered="#{questionpool.sortSubPoolProperty ne 'lastModified'}" />
       </h:commandLink>
      
       <h:commandLink title="#{questionPoolMessages.t_sortLastModified}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'lastModified' and questionpool.sortSubPoolAscending}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <h:outputText value="#{questionPoolMessages.last_mod}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'lastModified'}" />
          <f:param name="subPoolOrderBy" value="lastModified"/>
          <f:param name="subPoolAscending" value="false" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortLastModifiedDescending}" rendered="#{questionpool.sortSubPoolAscending eq true}" url="/images/sortascending.gif"/>
      </h:commandLink>
      <h:commandLink title="#{questionPoolMessages.t_sortLastModified}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'lastModified' and questionpool.sortSubPoolAscending eq false}" action="#{questionpool.sortSubPoolByColumnHeader}">
           <h:outputText value="#{questionPoolMessages.last_mod}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'lastModified'}" />
          <f:param name="subPoolOrderBy" value="lastModified"/>
          <f:param name="subPoolAscending" value="true" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortLastModifiedAscending}" rendered="#{questionpool.sortSubPoolAscending eq false}" url="/images/sortdescending.gif"/>
      </h:commandLink>
     </h:panelGroup>
     </f:facet>
     <h:panelGroup id="thirdcolumn">
        <h:outputText value="#{pool.lastModified}">
          <f:convertDateTime dateStyle="medium" timeStyle="short" timeZone="#{author.userTimeZone}" />
        </h:outputText>
     </h:panelGroup>
    </h:column>

    <h:column id="col4">
     <f:facet name="header">
      <h:panelGroup>
       <h:commandLink title="#{questionPoolMessages.t_sortNumQuestions}" id="sortByQuestion" immediate="true" rendered="#{questionpool.sortSubPoolProperty ne 'questionSize'}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <f:param name="subPoolOrderBy" value="questionSize"/>
          <f:param name="subPoolAscending" value="true"/>
          <h:outputText value="#{questionPoolMessages.qs}" rendered="#{questionpool.sortSubPoolProperty ne 'questionSize'}" />
       </h:commandLink>
     
       <h:commandLink title="#{questionPoolMessages.t_sortNumQuestions}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'questionSize' and questionpool.sortSubPoolAscending eq true}" action="#{questionpool.sortSubPoolByColumnHeader}">
            <h:outputText value="#{questionPoolMessages.qs}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'questionSize'}" />
          <f:param name="subPoolOrderBy" value="questionSize"/>
          <f:param name="subPoolAscending" value="false" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortNumQuestionsDescending}" rendered="#{questionpool.sortSubPoolAscending eq true}" url="/images/sortascending.gif"/>
      </h:commandLink>
      <h:commandLink title="#{questionPoolMessages.t_sortNumQuestions}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'questionSize' and questionpool.sortSubPoolAscending eq false}" action="#{questionpool.sortSubPoolByColumnHeader}">
            <h:outputText value="#{questionPoolMessages.qs}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'questionSize'}" />
          <f:param name="subPoolOrderBy" value="questionSize"/>
          <f:param name="subPoolAscending" value="true" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortNumQuestionAscending}" rendered="#{questionpool.sortSubPoolAscending eq false}" url="/images/sortdescending.gif"/>
      </h:commandLink>
     </h:panelGroup>
     </f:facet>
     <h:panelGroup id="fourthcolumn">
        <h:outputText value="#{pool.data.questionPoolItemSize}"/>
     </h:panelGroup>
    </h:column>


    <h:column id="col5">
     <f:facet name="header">
 <h:panelGroup>
       <h:commandLink title="#{questionPoolMessages.t_sortNumSubpools}" id="sortBySubPool" immediate="true" rendered="#{questionpool.sortSubPoolProperty ne 'subPoolSize'}" action="#{questionpool.sortSubPoolByColumnHeader}">
          <f:param name="subPoolOrderBy" value="subPoolSize"/>
          <f:param name="subPoolAscending" value="true"/>
          <h:outputText value="#{questionPoolMessages.subps}" rendered="#{questionpool.sortSubPoolProperty ne 'subPoolSize'}" />
       </h:commandLink>
      
       <h:commandLink title="#{questionPoolMessages.t_sortNumSubpools}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'subPoolSize' and questionpool.sortSubPoolAscending eq true}" action="#{questionpool.sortSubPoolByColumnHeader}">
           <h:outputText value="#{questionPoolMessages.subps}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'subPoolSize'}" />
          <f:param name="subPoolOrderBy" value="subPoolSize"/>
          <f:param name="subPoolAscending" value="false" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortNumSubpoolsDescending}" rendered="#{questionpool.sortSubPoolAscending eq true}" url="/images/sortascending.gif"/>
      </h:commandLink>
      <h:commandLink title="#{questionPoolMessages.t_sortNumSubpools}" immediate="true" rendered="#{questionpool.sortSubPoolProperty eq 'subPoolSize' and questionpool.sortSubPoolAscending eq false}" action="#{questionpool.sortSubPoolByColumnHeader}">
            <h:outputText value="#{questionPoolMessages.subps}" styleClass="currentSort" rendered="#{questionpool.sortSubPoolProperty eq 'subPoolSize'}" />
          <f:param name="subPoolOrderBy" value="subPoolSize"/>
          <f:param name="subPoolAscending" value="true" />
          <h:graphicImage alt="#{questionPoolMessages.alt_sortNumSubpoolsAscending}" rendered="#{questionpool.sortSubPoolAscending eq false}" url="/images/sortdescending.gif"/>
      </h:commandLink>
      </h:panelGroup>
     </f:facet>
     <h:panelGroup id="fifthcolumn">
        <h:outputText value="#{pool.subPoolSize}"/>
     </h:panelGroup>
    </h:column>


  </h:dataTable>

